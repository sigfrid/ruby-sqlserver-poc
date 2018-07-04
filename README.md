# ruby-sqlserver-poc


FreeTDS is a driver that enables you to connect to SQL Server. It is a prerequisite for the connector you’ll get later in the tutorial to connect to SQL Server. Run the following commands to install FreeTDS:

```
brew install FreeTDS
```


## SQL Server setup

https://gist.github.com/sigfrid/7f9d94f83a9b81dcb87a947fe1b18152



### Trigger on Update
https://stackoverflow.com/questions/2983339/sql-server-update-trigger-get-fields-before-and-after-updated

```
select i.*, d.*
from inserted i
join deleted d on (i.id = d.id)
```
