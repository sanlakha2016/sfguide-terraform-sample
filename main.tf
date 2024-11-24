terraform {
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.87"
    }
  }
}

provider "snowflake" {
  account_name     = "ub95153"
  organization_name ="NDKUASZ"
  user ="sanlakha"
  role = "SYSADMIN"
  password="u2canB$$"
}

resource "snowflake_database" "db_DEV" {
  name = "EDP_DEV"
}

resource "snowflake_database" "db_qa" {
  name = "EDP_QA"
}

resource "snowflake_database" "db_prod" {
  name = "EDP_PROD"
}

resource "snowflake_schema" "db_RAW" {
  database = snowflake_database.db_DEV.name
  name = "RAW"
}

resource "snowflake_schema" "db_CONFORMED" {
  database = snowflake_database.db_DEV.name
  name = "CONFORMED"
}

resource "snowflake_warehouse" "warehouse" {
  name           = "TF_DEMO"
  warehouse_size = "xsmall"
  auto_suspend   = 60
}

resource "snowflake_table" "dev_sales" {
  database = snowflake_database.db_DEV.name
  schema = snowflake_schema.db_RAW.name
  name = "web_sales"
  column {
    name =  "ID" 
    type = "INT"
    nullable = false
  }
  column {
    name="Transaction_Date"
    type = "DATETIME"
    nullable = false
    comment = "Transaction Date on which sales has happened."
  }
  
}