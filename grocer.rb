def consolidate_cart(cart)
    cart.each_with_object({}) do |item, new_cart|
        k, v = item.first
        if new_cart.key?(k)
            new_cart[k][:count] += 1
        else
            new_cart[k] = v.merge(count: 1)
        end
    end
end

def apply_coupons(cart, coupons)
  return cart if coupons.count < 1
  discounted_cart = {}
  cart.each_key do |key|
    # if the cart item is not found in coupons add it
    if !coupons.find { |coupon| coupon[:item] == key}
      discounted_cart[key] = cart.delete(key)
      next
    else
      coupons.each do |coupon|
        if key == coupon[:item]
          discounted_name = "#{key} W/COUPON"
          coupon_value = coupon[:cost] / coupon[:num]
          if coupon[:num] > cart[key][:count]
            discounted_cart[discounted_name] = {:price => coupon_value, :clearance => cart[key][:clearance], :count => cart[key][:count]}
          else
            discounted_cart[discounted_name] = {:price => coupon_value, :clearance => cart[key][:clearance], :count => coupon[:num]}
          item_key_number = cart[key][:count]
            if item_key_number != coupon[:num]
                discounted_cart[key] = cart.delete(key)
                discounted_cart[key][:count] = item_key_number - coupon[:num]
            end
          end
        end
      end
    end
  end
  discounted_cart
end


def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
