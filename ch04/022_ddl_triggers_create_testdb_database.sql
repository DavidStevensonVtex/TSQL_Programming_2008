---------------------------------------------------------------------
-- DDL Triggers
---------------------------------------------------------------------

-- Evntdata() Function

---------------------------------------------------------------------
-- Database Level Triggers
---------------------------------------------------------------------

-- Create testdb database
USE master; 
IF DB_ID('testdb') IS NULL CREATE DATABASE testdb;
GO
USE testdb;
GO