from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session

from .database import Base, engine, get_db
from .models import Product, Order
from .schemas import (
    ProductResponse,
    OrderCreate,
    OrderResponse
)


app = FastAPI(
    title="ShopSphere API",
    version="1.0.0"
)


Base.metadata.create_all(bind=engine)


@app.get("/health")
def health():

    return {
        "status": "healthy",
        "application": "shopsphere-backend"
    }


@app.get(
    "/api/products",
    response_model=list[ProductResponse]
)
def get_products(
    db: Session = Depends(get_db)
):

    products = db.query(Product).all()

    return products


@app.get(
    "/api/products/{product_id}",
    response_model=ProductResponse
)
def get_product(
    product_id: int,
    db: Session = Depends(get_db)
):

    product = (
        db.query(Product)
        .filter(Product.id == product_id)
        .first()
    )

    if not product:

        return {
            "id": 0,
            "name": "Product not found",
            "description": "",
            "price": 0,
            "image_url": "",
            "stock": 0
        }

    return product


@app.post(
    "/api/orders",
    response_model=OrderResponse
)
def create_order(
    order: OrderCreate,
    db: Session = Depends(get_db)
):

    new_order = Order(
        customer_name=order.customer_name,
        customer_email=order.customer_email,
        total_amount=order.total_amount,
        status="PLACED"
    )

    db.add(new_order)

    db.commit()

    db.refresh(new_order)

    return new_order


@app.get(
    "/api/orders/{order_id}",
    response_model=OrderResponse
)
def get_order(
    order_id: int,
    db: Session = Depends(get_db)
):

    order = (
        db.query(Order)
        .filter(Order.id == order_id)
        .first()
    )

    return order
