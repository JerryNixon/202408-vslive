del dab-config.json

dab init --database-type mssql --connection-string "@env('my-connection-string')" --host-mode development 

dab add Department --source dbo.Department --permissions anonymous:*    

dab add Employee --source dbo.Department --permissions anonymous:*    

dab update "Department" --relationship "employees" --target.entity "Employee" --cardinality many --relationship.fields "Id:DepartmentId" 

dab add ReorgEmployee --source dbo.ReorgEmployee --source.type "stored-procedure" --source.params "EmployeeId:0,DepartmentId:0" --permissions "anonymous:execute" --rest.methods "get" --graphql.operation "mutation"
