class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
  
    require 'aws-sdk-dynamodb'
    client = Aws::DynamoDB::Client.new(endpoint: 'http://localhost:8000')

    item = {
      'identification' => @item.identification,
      'sk' => "METADATA2", 
      'Name' => @item.name,
      'email' => @item.email,
      'mobile' => @item.mobile
    }

    client.put_item({
      table_name: 'ingreso',
      item: item
    })
   
  rescue Aws::DynamoDB::Errors::ServiceError => e
    puts "Error al guardar en DynamoDB: #{e.message}"
  end

  def show
    require 'aws-sdk-dynamodb'
    client = Aws::DynamoDB::Client.new(endpoint: 'http://localhost:8000')
    
    response = client.get_item({
      table_name: 'ingreso',
      key: {
        'identification' => params[:id].to_s,
        'sk' => 'METADATA2'

      }
    })
    
    if response.item
      @item = response.item
    else
      @item = nil
    end
  end
  
  private

  def item_params
    params.require(:item).permit(:identification, :name, :email, :mobile)
  end
end
