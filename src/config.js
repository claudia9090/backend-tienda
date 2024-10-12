import { config } from "dotenv";
config({path:"C:\\computershop.env"});

export const PORT = process.env.PORT || 5000;
export const DB_HOST = process.env.DB_HOST || "192.168.1.4";
export const DB_USER = process.env.DB_USER || "root";
export const DB_PASSWORD = process.env.DB_PASSWORD || "QWER1234";
export const DB_DATABASE = process.env.DB_DATABASE || "tienda";
export const DB_PORT = process.env.DB_PORT || 3306;
export const EMAIL = process.env.EMAIL || 'email@gmail.com';
export const EMAIL_PASS = process.env.EMAIL_PASS || '1234';
export const STRIPE_KEY = process.env.STRIPE_KEY || '......';