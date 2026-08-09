import { useEffect, useState } from "react";


const API_BASE_URL = "/api";


function App() {

    const [products, setProducts] = useState([]);

    const [cart, setCart] = useState([]);

    const [loading, setLoading] = useState(true);

    const [customerName, setCustomerName] = useState("");

    const [customerEmail, setCustomerEmail] = useState("");

    const [message, setMessage] = useState("");


    useEffect(() => {

        fetch(`${API_BASE_URL}/products`)

            .then(response => response.json())

            .then(data => {

                setProducts(data);

                setLoading(false);

            })

            .catch(error => {

                console.error(error);

                setLoading(false);

            });

    }, []);


    function addToCart(product) {

        setCart([
            ...cart,
            product
        ]);

        setMessage(
            `${product.name} added to cart`
        );
    }


    function getTotal() {

        return cart.reduce(
            (total, product) =>
                total + product.price,
            0
        );

    }


    async function checkout() {

        if (!customerName || !customerEmail) {

            setMessage(
                "Please enter your name and email"
            );

            return;
        }


        if (cart.length === 0) {

            setMessage(
                "Your cart is empty"
            );

            return;
        }


        const response = await fetch(
            `${API_BASE_URL}/orders`,
            {
                method: "POST",

                headers: {
                    "Content-Type":
                        "application/json"
                },

                body: JSON.stringify({

                    customer_name:
                        customerName,

                    customer_email:
                        customerEmail,

                    total_amount:
                        getTotal()

                })
            }
        );


        const order = await response.json();


        setMessage(
            `Order #${order.id} created successfully`
        );


        setCart([]);

    }


    if (loading) {

        return (
            <div className="container">

                <h1>ShopSphere</h1>

                <p>Loading products...</p>

            </div>
        );
    }


    return (

        <div className="container">

            <header>

                <h1>ShopSphere</h1>

                <p>
                    Simple Cloud E-Commerce
                </p>

            </header>


            <section>

                <h2>Products</h2>


                <div className="products">

                    {products.map(product => (

                        <div
                            className="product"
                            key={product.id}
                        >

                            <img
                                src={product.image_url}
                                alt={product.name}
                            />


                            <h3>
                                {product.name}
                            </h3>


                            <p>
                                {product.description}
                            </p>


                            <strong>
                                ₹{product.price}
                            </strong>


                            <button
                                onClick={() =>
                                    addToCart(product)
                                }
                            >
                                Add to Cart
                            </button>

                        </div>

                    ))}

                </div>

            </section>


            <section className="cart">

                <h2>
                    Cart ({cart.length})
                </h2>


                {cart.map(
                    (product, index) => (

                        <div key={index}>

                            {product.name}
                            {" - "}
                            ₹{product.price}

                        </div>

                    )
                )}


                <h3>
                    Total: ₹{getTotal()}
                </h3>


                <input
                    type="text"
                    placeholder="Customer name"
                    value={customerName}
                    onChange={e =>
                        setCustomerName(
                            e.target.value
                        )
                    }
                />


                <input
                    type="email"
                    placeholder="Customer email"
                    value={customerEmail}
                    onChange={e =>
                        setCustomerEmail(
                            e.target.value
                        )
                    }
                />


                <button
                    onClick={checkout}
                >
                    Checkout
                </button>


                {message && (

                    <p className="message">
                        {message}
                    </p>

                )}

            </section>

        </div>

    );
}


export default App;
