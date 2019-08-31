//import 'package:Dimik/data/db/fb.dart';
import '../../data/rest/mixTask.dart'; // just for testing
import '../../models/mixTask.dart';



class MixTaskController{
  MixTaskRest mixRest=new MixTaskRest();
  
  
  //Future<List<FB> >getFBList(String token,int userId,int topicId,int taskId)async{
    Future<MixTaskList>getMixList(String token,String topic)async{
    // int count=await fbDatabaseHelper.getCount();
     //if(count==0)//table is empty
    // {
       
         MixTaskList mixList=await mixRest.getAllTask(token,topic).catchError((Object onError){
          print(onError.toString());
          print("Pour some sugar on me");
        });
    //     await _insertFBList(fbList);
    // }
    //List<FB>result = await fbDatabaseHelper.getFBList();
    print("Printing from controller");
    //print(mixList.list);
    return mixList;
  }

  // Future<void>_insertFBList(FBList fbList)async{
  //   List<FB>fList=fbList.fbs;
    
  //   for(int i=0;i<fList.length;i++)
  //   {
  //      fbDatabaseHelper.insertFB(fList[i]);
  //   }
  // }

  // Future<int> insertFB(FB fb)async
  // {
  //     return fbDatabaseHelper.insertFB(fb);
  // }

  // Future<int> updateFB(FB fb)async
  // {
  //     return fbDatabaseHelper.updateFB(fb);
  // }

  // Future<int> deleteTopic(int id)async
  // {
  //     return fbDatabaseHelper.deleteFB(id);
  // }

}

