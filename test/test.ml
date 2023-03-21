let () =
  (* ignore user's git configuration *)
  Unix.putenv "GIT_AUTHOR_NAME" "test";
  Unix.putenv "GIT_COMMITTER_NAME" "test";
  Unix.putenv "EMAIL" "test@example.com";
  Eio_main.run @@ fun env ->
    Lwt_eio.with_event_loop ~clock:env#clock
  @@ fun () -> Alcotest.run ~argv:[| "alcotest"; "--verbose" |] "solver-service" [ ("service", (Test_service.tests ~env)) ]
