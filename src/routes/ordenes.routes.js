import { Router } from "express";
import {
  createOrden,
  cantidadProductosCarrito,
  productosCarrito,
  eliminarProductoCarrito,
  pagarOrden,
  createCheckoutSession,
  success,
  cancel,
  getEstados,
  getOrdenesAdmin,
  actualizarEstadoOrden,
  getOrdenesCliente,
  confirmarOrdenRecibida
} from "../controllers/ordenes.controller.js";

const router = Router();

router.post("/orden/create", createOrden);

router.post("/orden/cantidadProductosCarrito", cantidadProductosCarrito);

router.post("/orden/productosCarrito", productosCarrito);

router.post("/orden/eliminarProductoCarrito", eliminarProductoCarrito);

router.post("/orden/pagarOrden", pagarOrden);

router.post("/orden/create-checkout-session", createCheckoutSession );

router.get("/orden/success", success );

router.get("/orden/cancel", cancel );

router.post("/orden/estados", getEstados );

router.post("/ordenes/admin", getOrdenesAdmin );

router.post("/orden/actualizarEstado", actualizarEstadoOrden );

router.post("/ordenes/cliente", getOrdenesCliente );

router.post("/orden/confirmarOrdenRecibida", confirmarOrdenRecibida );

export default router;
