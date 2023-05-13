import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Result "mo:base/Result";
import Principal "mo:base/Principal";
import Int "mo:base/Int";
import HashMap "mo:base/HashMap";

actor StudentWall {
  public type Message = {
    vote : Int;
    content : Content;
    creator : Principal;
  };

  public type Content = {
    #Text: Text;
    #Image: Blob;
    #Video: Blob;
  };

  var wall = HashMap.HashMap<Nat, Message>;
   
    // Add a new message to the wall
    writeMessage: shared (c : Content) -> async Nat;

    //Get a specific message by ID
    getMessage: shared query (messageId : Nat) -> async Result.Result<Message, Text>;

    // Update the content for a specific message by ID
    updateMessage: shared (messageId : Nat, c : Content) -> async Result.Result<(), Text>;

    //Delete a specific message by ID
    deleteMessage: shared (messageId : Nat) -> async Result.Result<(), Text>;

    // Voting
    upVote: shared (messageId  : Nat) -> async Result.Result<(), Text>;
    downVote: shared (messageId  : Nat) -> async Result.Result<(), Text>;

    //Get all messages
    getAllMessages : query () -> async [Message];

    //Get all messages
    getAllMessagesRanked : query () -> async [Message];
};