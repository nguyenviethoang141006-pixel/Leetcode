import sql from "mssql"; // gọi thư viện để dùng microsoft sql
import "dotenv/config"; // dùng để chuyển .env data sang process.env

const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  port: Number(process.env.DB_PORT),
  database: process.env.DB_NAME,
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};

export async function connectDB() {
  try {
    const pool = await sql.connect(dbConfig);
    console.log("Connected to SQL Server");
    return pool;
  } catch (error) {
    console.error("Database connection failed:", error);
    throw error;
  }
}

export { sql };