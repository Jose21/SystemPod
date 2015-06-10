dataSource {
    pooled = true    
    dialect="org.hibernate.dialect.PostgreSQLDialect"
    driverClassName = "org.postgresql.Driver"
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
            username = "sguser"
            password = "sgpasswd"
            url = "jdbc:postgresql://localhost:5432/sgdb"
            dbCreate = "update"         
        }
    }
    production {
        dataSource {
            username = "sguser"
            password = "sgpasswd"                
            url = "jdbc:postgresql://aa14b0zaa7u888z.cdrlazdkm8qf.us-west-2.rds.amazonaws.com:5432/sgdb" //sgcon.elasticbeanstalk.com
            //url = "jdbc:postgresql://aa1x5omb2qv0jfi.cdrlazdkm8qf.us-west-2.rds.amazonaws.com:5432/sgdb" //sgcon2.elasticbeanstalk.com
            dbCreate = "update"
            properties {
                maxActive = 100
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
