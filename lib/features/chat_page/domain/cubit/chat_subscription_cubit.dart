
import 'package:chat_client_app/core/app.dart';
import 'package:chat_client_app/features/chat_page/data/websocket/send_message.dart';
import 'package:chat_client_app/features/themes_page/data/websocket/user_connect.dart';
import 'package:chat_client_app/features/themes_page/domain/cubit/base_socket_subscription_cubit.dart';

class ChatSubscriptionCubit extends BaseSocketSubscriptionCubit<BaseSocketSubscriptionState>{
  ChatSubscriptionCubit():super(ChatNotInitState(), App.wsUrl);

  void initChat({required String currentId}){
    emit(UserNotConnectedState(currendThemeId: currentId));
  }
  
  @override
  void onReceivedSubscribedEvent(eventJson) {
    try{
      if(state is UserNotConnectedState){
        if(eventJson is UserJoinedInRoom){
          if(eventJson.id == (state as UserNotConnectedState).currendThemeId){
            emit(UserConnectedState());
          }
        }
      }
    }catch(_){
      emit(UserConnectionErrorState());
    }
  }

  void sendMessage(Message message){
    try{
      send(event: 'sendMessage', message: message);
    }catch(_){
      emit(SendMessageError());
    }
  }

}

class ChatNotInitState extends BaseSocketSubscriptionState{}
class ChatInitState extends BaseSocketSubscriptionState{}

class UserNotConnectedState extends BaseSocketSubscriptionState{
  const UserNotConnectedState({required this.currendThemeId});
  final String? currendThemeId;

  @override
  // TODO: implement props
  List<Object?> get props => [...super.props, currendThemeId];

  @override
  UserNotConnectedState copyWith({bool? isConnectionEstablished, String? currendThemeId}) => UserNotConnectedState(currendThemeId: currendThemeId);
}

class UserConnectedState extends BaseSocketSubscriptionState{}

class UserConnectionErrorState extends BaseSocketSubscriptionState{}

class SendMessageError extends BaseSocketSubscriptionState{}