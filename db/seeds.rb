masgruas = Enterprise.create(name: 'masgruas')
masgruas.users.create(email: 'jhernan@masgruas.com', password: '123456789')

softdreams = Enterprise.create(name: 'softdreams')
softdreams.users.create(email: 'darenas@softdreams.com', password: '123456789')

AdminUser.create!(email: 'admin@masgruas.com', password: '*M45gRuAs26798*', password_confirmation: '*M45gRuAs26798*') if Rails.env.development?
