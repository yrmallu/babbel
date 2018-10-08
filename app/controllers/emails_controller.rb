class EmailsController < ApplicationController
  EMAIL_FORMATS = {}

  def get_email_format
    sample_set.each do |k, v|
      name = k.split(" ")
      domain = v.split("@")
      if domain[0].eql?(name.join("").downcase)
        EMAIL_FORMATS[domain[1]] = email_format[0]
      elsif domain[0].eql?((name[1]+name[0]).downcase)
        EMAIL_FORMATS[domain[1]] = email_format[1]
      else
        EMAIL_FORMATS[domain[1]] = email_format[2]
     end
    end
  end

  def get_email
    render json: { error: "Please send employee name" } and return if params[:name].blank?
    render json: { error: "Please send domain" } and return if params[:domain].blank?
    name = params[:name].split(" ")
    domain = params[:domain]
    get_email_format unless EMAIL_FORMATS.keys.include?(domain)
    result = case EMAIL_FORMATS[domain]
    when "first_name_last_name"
      name.join("").downcase + "@" + domain
    when "last_name_first_name"
      (name[1]+name[0]).downcase + "@" + domain
    else
      (name[0].chr.downcase+name[1]).downcase + "@" + domain
    end
    render json: { email: result }, status: :ok
  end

  def email_format
    [
      "first_name_last_name",
      "last_name_first_name",
      "first_name_initial_last_name"
    ]
  end
  
  def sample_set
   {
    "John Doe" => "jdoe@babbel.com",
    "Arun Jay" => "jayarun@linkedin.com",
    "Mat Lee" => "matlee@google.com"
   }
  end
end
