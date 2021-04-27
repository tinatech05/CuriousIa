class Poll {
  final String id;
  final String creatorid;
  final String type;
  final List <String> urlpic;
  final List <double> vote;
  
  

  Poll({
    this.id, 
    this.creatorid,
    this.type,
    this.urlpic,
    this.vote, 
    
    });
  Poll.fromData(Map<String, dynamic> data)
      : id = data['id'],
        creatorid = data['creatorid'],
         type = data['type'],
        urlpic = data['urlpic'],
        vote = data['vote'];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creatorid': creatorid,
      'type': type,
      'urlpic': urlpic,
      'vote': vote,
    };
  }
}
