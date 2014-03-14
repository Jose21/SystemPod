dataSource {
    pooled = true
    username = "sgdb"
    password = "sgdb"
    driverClassName = "org.postgresql.Driver"
    url = "jdbc:postgresql://localhost:5432/sgdb"
    dialect="org.hibernate.dialect.PostgreSQLDialect"
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
        }
    }
    production {
        dataSource {
            dbCreate = "update"
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
