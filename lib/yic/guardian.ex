defmodule Yic.Guardian do
    use Guardian, otp_app: :yic
 
    alias Yic.Iam
 
    def subject_for_token(resource, _claims) do
      sub = to_string(resource.id)
      {:ok, sub}
    end
 
    def resource_from_claims(claims) do
      id = claims["sub"]
      resource = Iam.get_account!(id)
      {:ok,  resource}
    end
  end