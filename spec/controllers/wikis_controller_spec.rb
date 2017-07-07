require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user){create (:user)}
  let(:new_user) {User.create!(username: "user2", email:"new@example.com", password:"password", password_confirmation:"password")}
  let(:my_wiki){create (:wiki), user: user}

  context "anonymous user" do

    describe "GET index" do
      it "should be redirected to signin" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET show" do
      it "should be redirected to signin" do
        get :show, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET new" do
      it "should be redirected to signin" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "POST create" do
      it "should be redirected to signin" do
        post :create, wiki: {title: "New wiki", body: "This is the new body paragraph", private: false}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "GET edit" do
      it "should be redirected to signin" do
        get :edit, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "PUT update" do
      it "should be redirected to signin" do
        new_title = "New Title"
        new_body = "This is the new body paragraph"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body, private: false}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    describe "DELETE destroy" do
      it "should be redirected to signin" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

  end

  context "logged in user doing CRUD on owned wiki" do

    before do
      sign_in user
      user.confirm
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to wiki" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST #create" do

      it "increases the number of Wiki by 1" do
        expect{ post :create, wiki: {title: "My new wiki", body: "This is a new body paragraph", private: false} }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: "My new wiki", body: "This is a new body paragraph", private: false}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: "My new wiki", body: "This is a new body paragraph", private: false}
        expect(response).to redirect_to [Wiki.last]
      end

    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: my_wiki.id
        expect(response).to render_template :edit
      end

      it "assigns wiki to be updated to @wiki" do
        get :edit, id: my_wiki.id
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT #update" do
      it "updates wiki with expected attributes" do
        new_title = "new title"
        new_body = "This is a new body paragraph"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body, private: false}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = "new title"
        new_body = "This is a new body paragraph"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body, private: false}
        expect(response).to redirect_to [my_wiki]
      end
    end

    describe "DELETE #destroy" do
      it "returns http success" do
        delete :destroy, id: my_wiki.id
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wikis index" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to wikis_path
      end
    end

  end
  context "logged in user doing CRUD on non-owned wiki" do

    before do
      sign_in new_user
      new_user.confirm
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "assigns Wiki.all to wiki" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new
        expect(response).to render_template :new
      end

      it "instantiates @wiki" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    describe "POST #create" do

      it "increases the number of Wiki by 1" do
        expect{ post :create, wiki: {title: "My new wiki", body: "This is a new body paragraph", private: false} }.to change(Wiki,:count).by(1)
      end

      it "assigns the new wiki to @wiki" do
        post :create, wiki: {title: "My new wiki", body: "This is a new body paragraph", private: false}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      it "redirects to the new wiki" do
        post :create, wiki: {title: "My new wiki", body: "This is a new body paragraph", private: false}
        expect(response).to redirect_to [Wiki.last]
      end

    end

    describe "GET #edit" do
      it "returns http redirect" do
        get :edit, id: my_wiki.id
        expect(response).to redirect_to([my_wiki])
      end
    end

    describe "PUT #update" do
      it "updates wiki with expected attributes" do
        new_title = "new title"
        new_body = "This is a new body paragraph"

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body, private: false}

        expect(response).to redirect_to([my_wiki])
      end
    end

    describe "DELETE #destroy" do
      it "returns http redirect" do
        delete :destroy, id: my_wiki.id
        expect(response).to redirect_to([my_wiki])
      end
    end

  end

end
