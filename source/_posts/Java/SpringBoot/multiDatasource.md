---
title: SpringBoot基于注解的多数据源实现
categories: 
- [Java, SpringBoot]

tags:
- Java
- SpringBoot
- 动态多数据源
---

# SpringBoot基于注解的多数据源实现
开发过程中可能会有项目中访问多个数据源的要求，这里做个示范

## 1.配置数据源参数
在application.yml（其他配置文件也一样）中配置你的数据源信息

```yml
spring:
    datasource:
        master:
        url: jdbc:mysql://127.0.0.1:3306/sbac_master?autoReconnect=true&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true
        username: root
        password: 1234
        driver-class-name: com.mysql.cj.jdbc.Driver
    log:
        url: jdbc:mysql://127.0.0.1:3306/sbac_log?autoReconnect=true&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&allowMultiQueries=true
        username: root
        password: 1234
        driver-class-name: com.mysql.cj.jdbc.Driver

```

## 2.配置数据源Bean
```java
@Configuration
public class MultiDataSource {

    public static final String MASTER_DATA_SOURCE = "masterDataSource";
    public static final String LOG_DATA_SOURCE = "logDataSource";

    @Bean(name = MultiDataSource.MASTER_DATA_SOURCE)
    @ConfigurationProperties(prefix = "datasource.master")
    public DataSource masterDataSource() {
        return DruidDataSourceBuilder.create().build();
    }

    @Bean(name = MultiDataSource.LOG_DATA_SOURCE)
    @ConfigurationProperties(prefix = "datasource.log")
    public DataSource logDataSource() {
        return DruidDataSourceBuilder.create().build();
    }

    @Primary
    @Bean(name = "dynamicDataSource")
    public DynamicDataSource dataSource() {
        DynamicDataSource dynamicDataSource = new DynamicDataSource();
        dynamicDataSource.setDefaultTargetDataSource(masterDataSource());
        Map<Object, Object> dataSourceMap = new HashMap<>(4);
        dataSourceMap.put(MASTER_DATA_SOURCE, masterDataSource());
        dataSourceMap.put(LOG_DATA_SOURCE, logDataSource());
        dynamicDataSource.setTargetDataSources(dataSourceMap);
        return dynamicDataSource;
    }
}

```

MASTER_DATA_SOURCE和LOG_DATA_SOURCE是我们的俩个数据源的名字，这里有个问题需要注意一下，因为我们使用的是阿里巴巴的Druid连接池，因此在创建Datasource的Bean的时候需要返回DruidDataSourceBuilder而不是DataSourceBuilder

另外，我们需要@Primary标签来指定一个默认的数据源，但是这个默认的数据源不是我们自己创建的俩个Bean，而是我们自己定义的一个动态数据源DynamicDataSource


## 3.配置动态数据源DynamicDataSource

```java
public class DynamicDataSource extends AbstractRoutingDataSource {
    private static final Logger LOGGER = LoggerFactory.getLogger(DynamicDataSource.class);

    private static final ThreadLocal<String> DATA_SOURCE_KEY =ThreadLocal.withInitial(()->MultiDataSource.MASTER_DATA_SOURCE);

    static void changeDataSource(String dataSourceKey) {
        DATA_SOURCE_KEY.set(dataSourceKey);
    }

    static void clearDataSource() {
        DATA_SOURCE_KEY.remove();
    }

    @Override
    protected Object determineCurrentLookupKey() {
        String key = DATA_SOURCE_KEY.get();
        LOGGER.info("current data-source is {}", key);
        return key;
    }
}

```

DynamicDataSource继承自AbstractRoutingDataSource，AbstractRoutingDataSource是Spring官方提供的一个进行动态路由切换的一个类，核心是determineCurrentLookupKey方法，通过覆写该方法来确定我们调用数据源的逻辑，这里只是进行了简单的返回。

我们定义了一个线程安全的变量DATA_SOURCE_KEY来存储数据源信息，确保线程安全，同时通过ThreadLocal.withInitial(()->MultiDataSource.MASTER_DATA_SOURCE)指定默认的数据源


## 4.自定义注解
核心的数据源动态切换的逻辑有了，接下来就是调用了，我们通过注解来调用数据源，首先自定义一个注解

```java
@Documented
@Inherited
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
public @interface DataSource {

    String value();
}
```

## 5.通过AOP实现数据源的切换
```java
@Component
@Aspect
public class DataSourceConfig {

    @Before("@annotation(dataSource)")
    public void beforeSwitchDataSource(DataSource dataSource) {
        DynamicDataSource.changeDataSource(dataSource.value());
    }

    @After("@annotation(DataSource)")
    public void afterSwitchDataSource() {
        DynamicDataSource.clearDataSource();
    }
}

```


## 6.调用
在service层或者Mapper层都可以，我这里使用的是mybatis，所以在mapper层调用的

```java

@Mapper
public interface DynamicDataSourceMapper{


    @Select("select * from user")
    @DataSource(value = MultiDataSource.MASTER_DATA_SOURCE)
    public void getUser(User user);

    @Select("select * from log")
    @DataSource(value = MultiDataSource.LOG_DATA_SOURCE)
    public List<object> getLog();

 
}


```
