-- SQL script to create the initial database for TechSoft Solutions

-- Create database only if it doesn't exist
SELECT 'CREATE DATABASE techsoft_db'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'techsoft_db')\gexec