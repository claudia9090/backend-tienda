import express from "express";
import morgan from "morgan";
import cors from 'cors';
import path from "path"
import { fileURLToPath } from 'url';
import productosRoutes from "./routes/productos.routes.js";
import categoriasRoutes from "./routes/categorias.routes.js";
import usuariosRoutes from "./routes/usuarios.routes.js";
import ordenesRoutes from "./routes/ordenes.routes.js";
import rolesRoutes from "./routes/roles.routes.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

// Middlewares
app.use(morgan("dev"));
app.use(express.json());
app.use(cors());
// app.use(express.urlencoded({extended: true}))
// Routes
app.use(express.static('public'));
app.use('/api/imagenes', express.static(path.join(__dirname, 'imagenes')));

app.use("/api", productosRoutes);
app.use("/api", categoriasRoutes);
app.use("/api", usuariosRoutes);
app.use("/api", ordenesRoutes);
app.use("/api", rolesRoutes);

app.use((req, res, next) => {
  res.status(404).json({ message: "Not found" });
});

export default app;

//  select JSON_ARRAYAGG(JSON_OBJECT('id', id, 'nombre', nombre, 'descripcion', descripcion, 'precio', precio, 'imagen', imagen )) result from productos
