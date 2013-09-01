dataSource {
    pooled = true
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop"
            username = "sa"
            password = ""
            driverClassName = "org.h2.Driver"
            url = "jdbc:h2:devDb;MVCC=TRUE;LOCK_TIMEOUT=10000"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            username = "sgdemo"
            password = "sgdemo"
            driverClassName = "org.postgresql.Driver"
            url = "jdbc:postgresql://postgres-infonavit.jelastic.servint.net/sgdemo"
            dialect="org.hibernate.dialect.PostgreSQLDialect"
            properties {
                maxActive = -1
                minEvictableIdleTimeMillis=1800000
                timeBetweenEvictionRunsMillis=1800000
                numTestsPerEvictionRun=3
                testOnBorrow=true
                testWhileIdle=true
                testOnReturn=true
                validationQuery="SELECT 1"
            }
        }
    }
}
