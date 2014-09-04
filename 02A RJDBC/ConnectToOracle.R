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

# The following data.frame will be used as the default if emps can't be loaded from Oracle.
e1 <- 7369
e2 <- 'SMITH'
e3 <- 'CLERK'
e4 <- 7902
e5 <- '17-DEC-1980'
e6 <- 800
e7 <- 20
emps <- data.frame(e1,e2,e3,e4,e5,e6,e7)
col_headings <- c('EMPNO', 'ENAME', 'JOB', 'MGR', 'HIREDATE', 'SAL', 'DEPTNO')
names(emps) <- col_headings

possibleError <- tryCatch(
  # In the following, use your username and password instead of "CS347_prof", "orcl_prof"
  jdbcConnection <- dbConnect(jdbcDriver, "jdbc:oracle:thin:@zenji.microlab.cs.utexas.edu:1521:orcl", "C##cs347_prof", "orcl_prof"),
  error=function(e) e
)
if(!inherits(possibleError, "error")){
  emps <- dbGetQuery(jdbcConnection, "select * from emp")
  dbDisconnect(jdbcConnection)
}

ggplot(data = emps) + geom_histogram(aes(x = SAL))

