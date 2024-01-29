class MockController < ApplicationController
  def slow_service
    sleep(1)
    render plain: "This is a cool pet you might like!"
  end

  def outlier
    if slow_down?
      sleep(2)
      render plain: "This is a REALLY cool pet you might like!"
    else
      render plain: "This is a cool pet you might like!"
    end
  end

  private

  def slow_down?
    params[:id].to_i % 100 == 0
  end
end
