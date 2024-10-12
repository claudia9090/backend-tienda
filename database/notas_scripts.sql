--solucion error cuando se instala mysql y aparece 
/*
code: 'ER_ACCESS_DENIED_ERROR',
  errno: 1045,
  sql: undefined,
  sqlState: '28000',
  sqlMessage: "Access denied for user 'root'@'15J96G3.itcol.com' (using password: YES)"
*/

CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'QWER1234';

ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'QWER1234';

GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';
FLUSH PRIVILEGES;