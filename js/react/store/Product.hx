package react.store;
import react.ReactComponent;
import react.ReactMacro.jsx;
import Common;

typedef ProductProps = {
  var product:ProductInfo;
  var addToCart:ProductInfo -> Int -> Void;
};

typedef ProductState = {
  var quantity:Int;
};

class Product extends react.ReactComponentOfPropsAndState<ProductProps, ProductState>
{
  public function new() {
    super();
    state = {
      quantity: 1
    };
  }

  override public function render(){
    var product = props.product;

    return jsx('
      <div className="product">
        <img src=${product.image} alt={product.name} />
        <div className="body">
          <div>${product.name}</div>
          <div>${product.price} €</div>
          <input type="number" value=${state.quantity} onChange=$updateQuantity />
          <div className="button" onClick=$addToCart>Commander</div>
        </div>
      </div>
    ');
  }

  function updateQuantity(event:Dynamic) {
    var quantity = Std.parseInt(event.target.value);

    if (Std.is(quantity, Int) && quantity > 0)
      setState({
        quantity: Std.int(quantity)
      });
  }

  function addToCart() {
    props.addToCart(props.product, state.quantity);
  }

  function openPopin() {
    trace('Opening Popin');
  }
}
