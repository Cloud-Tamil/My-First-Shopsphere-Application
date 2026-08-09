from pydantic import BaseModel


class ProductResponse(BaseModel):

    id: int

    name: str

    description: str

    price: float

    image_url: str

    stock: int

    class Config:
        from_attributes = True


class OrderCreate(BaseModel):

    customer_name: str

    customer_email: str

    total_amount: float


class OrderResponse(BaseModel):

    id: int

    customer_name: str

    customer_email: str

    total_amount: float

    status: str

    class Config:
        from_attributes = True
