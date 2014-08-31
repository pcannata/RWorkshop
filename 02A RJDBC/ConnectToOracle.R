"
Put the following into .bash_profile 
export JAVA_HOME=`/usr/libexec/java_home` 
. ./.bash_profile 

Download ojdbc6.jar into ~/Downloads 
sudo mv ~/Downloads/ojdbc6.jar $JAVA_HOME 
"
# In the following, use your path instead of /Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home

Sys.setenv(JAVA_HOME='/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home')
options(java.parameters="-Xmx2g")
library(rJava)

# Output Java version
.jinit()
print(.jcall("java/lang/System", "S", "getProperty", "java.version"))

# Load RJDBC library
library(RJDBC)

jdbcDriver <- JDBC(driverClass="oracle.jdbc.OracleDriver", classPath="/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home/ojdbc6.jar")

# In the following, use your username and password instead of "CS347_prof", "orcl_prof"
jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@rising-sun.microlab.cs.utexas.edu:1521:orcl", "CS347_prof", "orcl_prof")

instanceName <- dbGetQuery(jdbcConnection, "SELECT instance_name FROM v$instance")
print(instanceName)

# Get data from the emp table into a dataframe named emps
emps <- dbGetQuery(jdbcConnection, "select * from emp")
# Histogram the SAL variable in emps using ggplot2 (ggplot2 will be discussed in the next section).
ggplot(data = emps) + geom_histogram(aes(x = SAL))

dbDisconnect(jdbcConnection)


