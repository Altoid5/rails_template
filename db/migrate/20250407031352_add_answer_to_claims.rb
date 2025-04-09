@claim = @found_item.claims.build(
  user: current_user,
  answer: params[:answer],
  proof_provided: true,
  status: "pending"
)