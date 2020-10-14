module Api
	module V1
		class InventoriesController < ApplicationController
			def index
				inventories = Inventory.all

				render json: {inventories: inventories}
			end

			def create
				productname = inventory_params[:productname]
				duplicate = 1
				unless(Inventory.find_by_productname(productname))
					duplicate = 0
				end
				if(duplicate == 1)
					render json: {success: 0, message: 'Given Post Title is already present'}, status: :ok
				else
					inventory = Inventory.new(inventory_params)

					if(inventory.save)
						render json: {success: 1, message: 'Added Post'}, status: :ok
					else
						render json: {success: 0, message: 'Post not added'}, status: :ok
					end
				end
			end

			def update
				productname = inventory_params[:productname]
				duplicate = 1
				unless (Inventory.where("productname = ?", productname).count > 1)
					duplicate = 0
				end
				if(duplicate == 1)
					render json: {success: 0, message: 'Given Post Title is already present'}, status: :ok
				else
					inventory = Inventory.find(params[:id])

					if(inventory.update_attributes(inventory_params))
						render json: {success: 1, message: 'Modified Post'}, status: :ok
					else
						render json: {success: 0, message: 'Post not modified'}, status: :ok
					end
				end
			end

			def destroy
				inventory = Inventory.find(params[:id])
				if(inventory.destroy)
					render json: {success: 1, message: 'Deleted Post'}, status: :ok
				else
					render json: {success: 0, message: 'Post not deleted'}, status: :ok
				end
			end


			private

			def inventory_params
			   params.permit(:productname, :vendor)
			end
		end
	end
end