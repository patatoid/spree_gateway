module Spree
	CheckoutController.class_eval do
		 def update
			 if @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
				 @order.temporary_address = !params[:save_user_address]
				 unless @order.next
					 flash[:error] = @order.errors.full_messages.join("\n").force_encoding('windows-1254').encode('utf-8')
					 redirect_to checkout_state_path(@order.state) and return
				 end
				 if @order.completed?
					 @current_order = nil
					 flash.notice = Spree.t(:order_processed_successfully)
					 flash['order_completed'] = true
					 redirect_to completion_route
				 else
					 redirect_to checkout_state_path(@order.state)
				 end
			 else
				 render :edit
			 end
		 end
	end
end