class ProductNotifier
  include Sidekiq::Worker
  include ActionDispatch::Routing
  include Rails.application.routes.url_helpers

  sidekiq_options retry: false

  def perform(action, params = {})
    send(action, params)
  end

  private

  def submitted(params)
    user = User.find(params['user_id'])
    product = Product.find(params['product_id'])
    company = product.company
    date = I18n.l(Time.now)
    User::Tenant.admins.each do |admin|
      ProductMailer.submitted(admin, user, company, product, date).deliver
      message = I18n.t('notifications.product.submitted', user: user.name, company: company.name, product: product.name, date: date, link: admin_partner_products_path)
      admin.notifications.create(message: message)
    end
  end

  def retracted(params)
    user = User.find(params['user_id'])
    product = Product.find(params['product_id'])
    company = product.company
    User::Tenant.admins.each do |admin|
      ProductMailer.retracted(admin, user, company, product).deliver
      message = I18n.t('notifications.product.retracted', user: user.name, company: company.name, product: product.name)
      admin.notifications.create(message: message)
    end
  end

  def published(params)
    product = Product.find(params['product_id'])
    company = product.company
    company.users.admins.each do |admin|
      ProductMailer.published(admin, company, product).deliver
      admin.notifications.create(message: I18n.t('notifications.product.published', product: product.name, company: company.name))
    end
  end

  def declined(params)
    product = Product.find(params['product_id'])
    product.company.users.admins.each do |admin|
      ProductMailer.declined(admin, product, params['reason']).deliver
      message = I18n.t('notifications.product.declined', product: product.name, reason: params['reason'], link: admin_products_path)
      admin.notifications.create(message: message)
    end
  end

  def unpublished(params)
    product = Product.find(params['product_id'])
    product.company.users.admins.each do |admin|
      ProductMailer.unpublished(admin, product, params['reason']).deliver
      message = I18n.t('notifications.product.unpublished', product: product.name, reason: params['reason'], link: admin_products_path)
      admin.notifications.create(message: message)
    end
  end

end
