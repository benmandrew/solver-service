module Make (_ : Opam_repository_intf.S) : sig
  module Epoch : sig
    type t_process = < stdin : Eio.Flow.sink ; stdout : Eio.Flow.source >
    type t

    val process :
      log:Solver_service_api.Solver.Log.X.t Capnp_rpc_lwt.Capability.t ->
      id:string ->
      Solver_service_api.Worker.Solve_request.t ->
      t_process ->
      (string list, string) result
    (** [process ~log ~id request process] will write the [request] to the stdin
        of [procress] and read [stdout] returning the packages. Information is
        logged into [log] with [id]. *)
  end

  val v :
    n_workers:int ->
    create_worker:(Remote_commit.t list -> Epoch.t_process) ->
    Solver_service_api.Solver.t Lwt.t
  (** [v ~n_workers ~create_worker] is a solver service that distributes work to
      up to [n_workers] subprocesses, using [create_worker hash] to spawn new
      workers. *)
end
