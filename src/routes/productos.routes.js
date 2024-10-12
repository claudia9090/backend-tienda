import { Router } from "express";
import {
  createProducto,
  getProductos,
  getProductosAdmin,
  getProducto,
  updateProducto,
  updateProductoImage,
  getProductosByCategoria,
  getProductosByBusqueda,
  getProductosByOrdenId,
} from "../controllers/productos.controller.js";

import multer from "multer";
import { v4 as uuidv4 } from 'uuid';

import path from "path"

import { fileURLToPath } from 'url';
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const storage = multer.diskStorage({
  destination: path.join(__dirname, '../imagenes'),
  filename:  (req, file, cb) => {
      cb(null, uuidv4() + '.jpg');
  }
})
const uploadImage = multer({
  storage,
  limits: {fileSize: 1000000}
}).single('image');
 

const router = Router();

// GET all Productos
router.get("/productos", getProductos);

// GET all Productos Admin
router.get("/productos/admin", getProductosAdmin);

// GET An Producto
router.get("/producto/:id", getProducto);

// INSERT An Producto
router.post("/producto/create", uploadImage, createProducto);

// UPDATE An Producto
router.post("/producto/update", updateProducto);

// UPDATE Image Producto
router.post("/producto/update/image", uploadImage, updateProductoImage);

// GET all Productos by categoria
router.get("/productosByCategoria", getProductosByCategoria);

// GET all Productos by busqueda
router.get("/productosByBusqueda", getProductosByBusqueda);

router.get("/productosByOrdenId", getProductosByOrdenId);

export default router;
