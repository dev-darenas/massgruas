ActiveAdmin.register User do
  permit_params :fullname,
                :email,
                :rol,
                :password,
                :enterprise_id

  index do
    selectable_column
    column :fullname
    column :email
    column :rol
    column :enterprise
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :fullname
      f.input :email
      f.input :rol, as: :select, collection: User.rols.keys
      f.input :enterprise
      f.input :password
    end
    f.actions
  end
end
