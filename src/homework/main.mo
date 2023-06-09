import Bool "mo:base/Bool";
import Time "mo:base/Time";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";
import Result "mo:base/Result";

actor Homework{
  public type Time = Time.Time;

  public type Homework = {
    title : Text;
    description : Text;
    time : Time;
    completed : Bool;
  };

  var homeworkDiary = Buffer.Buffer<Homework>(1);
  var hwId : Nat = 0;

  public func addHomework(hw : Homework) : async Nat {
    homeworkDiary.add(hw);
    hwId := homeworkDiary.size() - 1;
    return hwId;
  };

  public func getHomework(homeworkId : Nat) : async Result.Result<Homework, Text> {
    if (homeworkId >= 0 and homeworkId < homeworkDiary.size()) {
      return #ok(homeworkDiary.get(homeworkId));
    } else {
      return #err("Invalid id");
    }
  };

  public func updateHomework(homeworkId : Nat, task : Homework) : async Result.Result<(), Text> {
    if (homeworkId >= 0 and homeworkId < homeworkDiary.size()) {
      var hwUpdated = {
        title = task.title;
        description = task.description;
        time = task.time;
        completed = task.completed;
      };

      let x = homeworkDiary.remove(homeworkId);
      homeworkDiary.insert(homeworkId, hwUpdated);

      return #ok();

    } else {
      return #err("Invalid id");
    }
  };

  public func markAsCompleted(homeworkId : Nat) : async Result.Result<Homework, Text> {
    if (homeworkId >= 0 and homeworkId < homeworkDiary.size()) {
      var hwCompleted = {
        title = homeworkDiary.get(homeworkId).title;
        description = homeworkDiary.get(homeworkId).description;
        time = homeworkDiary.get(homeworkId).time;
        completed = true;
      };

      let x = homeworkDiary.remove(homeworkId);
      homeworkDiary.insert(homeworkId, hwCompleted);
      
      return #ok(homeworkDiary.get(homeworkId));

    } else {
      return #err("Invalid id");
    }
  };

  public func deleteHomework(homeworkId: Nat) : async Result.Result<(), Text> {
    if (homeworkId >= 0 and homeworkId < homeworkDiary.size()) {
      var hwDeleted = homeworkDiary.remove(homeworkId);
      return #ok();

    } else {
      return #err("Invalid id");
    }
  };

  public func getAllHomework() : async [Homework] {
    var clone = Buffer.toArray(homeworkDiary);
    return clone;
  };

  public func getPendingHomework() : async [Homework] {
    var clone = Buffer.clone(homeworkDiary);
    clone.filterEntries(func(_, hwStatus) = hwStatus.completed == false);
    return Buffer.toArray(clone);
  };

  public func searchHomework(searchTerm : Text) : async [Homework] {
    var clone = Buffer.clone(homeworkDiary);
    clone.filterEntries(func(_, hwStatus) = hwStatus.title == searchTerm);
    return Buffer.toArray(clone);
  };
};
