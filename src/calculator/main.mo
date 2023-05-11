import Debug "mo:base/Debug";
import Float "mo:base/Float";

actor Calculator {
  var counter : Float = 0;

  public func add(n : Float) : async Float {
    counter += n;
    return counter;
  };

  public func sub(n : Float) : async Float {
    counter -= n;
    return counter;
  };

  public func mul(n : Float) : async Float {
    counter *= n;
    return counter;
  };

  public func div(n : Float) : async ?Float {
    if (n == 0) {
      return null;
    } else {
      counter /= n;
      return ?counter;
    };
  };

  public func reset() : async Float {
    counter := 0;
    return counter;
  };

  public func see() : async Float {
    return counter;
  };

  public func power(n : Float) : async Float {
    counter **= n;
    return counter;
  };

  public func sqrt() : async Float {
    counter := Float.sqrt(counter);
    return counter;
  };

  public func floor() : async Float {
    counter := Float.floor(counter);
    return counter;
  };
};
