Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # 「/」ページに来たら「users」コントローラーの「index」アクションに処理を通す
  get '/', to: 'users#index'
end
