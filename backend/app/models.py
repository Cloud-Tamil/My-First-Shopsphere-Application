from sqlalchemy import Column, Integer, String, Float, DateTime
from datetime import datetime

from .database import Base


class Product(Base):

    __tablename__ = "products"

    id = Column(Integer, primary_key=True, index=True)

    name = Column(String(200), nullable=False)

    description = Column(String(1000))

    price = Column(Float, nullable=False)

    image_url = Column(String(500))

    stock = Column(Integer, default=0)


class Order(Base):

    __tablename__ = "orders"

    id = Column(Integer, primary_key=True, index=True)

    customer_name = Column(String(200), nullable=False)

    customer_email = Column(String(200), nullable=False)

    total_amount = Column(Float, nullable=False)

    status = Column(String(50), default="PLACED")

    created_at = Column(
        DateTime,
        default=datetime.utcnow
    )
