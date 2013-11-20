//Ready for Grails 2.3.0

grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolver = "maven"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        mavenRepo "http://snapshots.repository.codehaus.org"
        mavenRepo "http://repository.codehaus.org"
        mavenRepo "http://download.java.net/maven/2/"
        mavenRepo "http://repository.jboss.com/maven2/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        // runtime 'mysql:mysql-connector-java:5.1.22'
    }

    plugins {
        compile ':hibernate:3.6.10.2'
        //runtime ":hibernate:$grailsVersion"
        runtime ":jquery:1.8.3"
        runtime ":resources:1.2"

        compile ":scaffolding:2.0.0"
        
        compile ":grails-melody:1.47.2"
        // Uncomment these (or add new ones) to enable additional resources capabilities
        //runtime ":zipped-resources:1.0"
        //runtime ":cached-resources:1.0"
        //runtime ":yui-minify-resources:0.1.5"

        compile ":jquery-ui:1.8.24"
        compile ":famfamfam:1.0.1"
        compile ":mail:1.0.1", {
            excludes 'spring-test'
        }
        compile ":asynchronous-mail:1.0"
        
        compile ":spring-security-core:1.2.7.3"
        compile ":spring-security-ui:0.2"
        
        build ":tomcat:7.0.42"
        //build ":tomcat:$grailsVersion"
        runtime ":database-migration:1.3.2"
        compile ':cache:1.0.1' 
        compile ":export:1.5"
    }
}

forkConfig = [maxMemory: 2048, minMemory: 256, debug: false, maxPerm: 1024]
grails.project.fork = [   
    run: forkConfig, // configure settings for the run-app JVM
    //war: forkConfig, // configure settings for the run-war JVM
]