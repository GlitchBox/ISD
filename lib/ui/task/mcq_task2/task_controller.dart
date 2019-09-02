
/*
import '../../data/rest_ds.dart';
import '../../models/task.dart';

abstract class TaskScreenContract {
  void onTaskListChanged(List<Task> list);
  void onTaskListObtained(List<Task> list);
  void onTaskError(String errortxt);
}

class TaskScreenPresenter {
  TaskScreenContract _view;
  RestDatasource api = new RestDatasource();
  TaskScreenPresenter(this._view);

  getTasks() {
    //TODO: get token from database
    final tokenAuth = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImUxMzYzZjRmMzU1YmMyNGJhOWMxOWRjMzRkZjQwNDViZGRjZTgzYjNmZDM1ZTRlNTczMzViOTVjNTYzZWYwYWFlN2UzMmQ3NzU3NThmOWFlIn0.eyJhdWQiOiIxIiwianRpIjoiZTEzNjNmNGYzNTViYzI0YmE5YzE5ZGMzNGRmNDA0NWJkZGNlODNiM2ZkMzVlNGU1NzMzNWI5NWM1NjNlZjBhYWU3ZTMyZDc3NTc1OGY5YWUiLCJpYXQiOjE1NDk5ODc5ODgsIm5iZiI6MTU0OTk4Nzk4OCwiZXhwIjoxNTgxNTIzOTg4LCJzdWIiOiI2Iiwic2NvcGVzIjpbXX0.ZJBV_3-TURkCsmJOP8nshCrM5x0p6_a2tKu-svtUewzq8VMarz9LYrGg99XOtUf7MzbQSG9N9qXuX9h0sdhe40u4B_gxym0pI0COX3vjkqfM3iR4TyQXFgIcvYnCMoePOkgm7m_bVsNJJuEkRUC5SM1xcJwu144g13UfArDSmjAx37grDauYUYEMmFRBeXS-iaOeXKaDkbTvOYCHhp8vDxDIR7E92t58bOrwjz6pVkSfg7jYDpwV3m6A35uAxieb6-4HC6xmldKnSkt5D_7P73tIo0AymBvlj0LqfUsbH3jCwwjgiIcmqbU3XzdFhSadt8lxC-6bKljO9iS42lNcQBFkT3UQFgQAnhz7XNIEz41YNz9ZtgwHX4h1OR5z9T5HcyF0XW3Fmy2c_FL1WqFJ3UGynTOukjf7l8cdKOozEZ0hkqmxgmfWU7zzsE6ivbeVgtTfsbCj7BrVWDIJdWlDgnIExpwOxHfc_OllAIh5OKOfKiaw5nmUGTNvEdpP_4oMDp4g-owu7K5-YlLUZVePxO6XjpdFJXWjogTciZ-iGSfeOw3nlolm3EGO3PiJiK8ppcGZ87ObvXZ9hlMuNJ_p7qXJc7fo-itgBTJH4UvhXjpL92pjx5wD_3qYR8hn4-6t7eEovzAfHRaQ1UxZEe7_qsI4OoXEHk5TaA1TqDtrlqs";
    api.allTasks(tokenAuth).then((List<Task> token) {
      _view.onTaskListObtained(token);
    }).catchError((Exception error) => _view.onTaskError(error.toString()));
  }

  
}*/
