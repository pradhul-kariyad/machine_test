// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class HomeModel {
  User? user;
  List<HeroBanners>? heroBanners;
  ActiveCourse? activeCourse;
  List<PopularCourses>? popularCourses;
  LiveSession? liveSession;
  Community? community;
  List<Testimonials>? testimonials;
  Support? support;

  HomeModel(
      {this.user,
      this.heroBanners,
      this.activeCourse,
      this.popularCourses,
      this.liveSession,
      this.community,
      this.testimonials,
      this.support});

  HomeModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['hero_banners'] != null) {
      heroBanners = <HeroBanners>[];
      json['hero_banners'].forEach((v) {
        heroBanners!.add(HeroBanners.fromJson(v));
      });
    }
    activeCourse = json['active_course'] != null
        ? ActiveCourse.fromJson(json['active_course'])
        : null;
    if (json['popular_courses'] != null) {
      popularCourses = <PopularCourses>[];
      json['popular_courses'].forEach((v) {
        popularCourses!.add(PopularCourses.fromJson(v));
      });
    }
    liveSession = json['live_session'] != null
        ? new LiveSession.fromJson(json['live_session'])
        : null;
    community = json['community'] != null
        ? new Community.fromJson(json['community'])
        : null;
    if (json['testimonials'] != null) {
      testimonials = <Testimonials>[];
      json['testimonials'].forEach((v) {
        testimonials!.add(new Testimonials.fromJson(v));
      });
    }
    support =
        json['support'] != null ? new Support.fromJson(json['support']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.heroBanners != null) {
      data['hero_banners'] = this.heroBanners!.map((v) => v.toJson()).toList();
    }
    if (this.activeCourse != null) {
      data['active_course'] = this.activeCourse!.toJson();
    }
    if (this.popularCourses != null) {
      data['popular_courses'] =
          this.popularCourses!.map((v) => v.toJson()).toList();
    }
    if (this.liveSession != null) {
      data['live_session'] = this.liveSession!.toJson();
    }
    if (this.community != null) {
      data['community'] = this.community!.toJson();
    }
    if (this.testimonials != null) {
      data['testimonials'] = this.testimonials!.map((v) => v.toJson()).toList();
    }
    if (this.support != null) {
      data['support'] = this.support!.toJson();
    }
    return data;
  }
}

class User {
  String? name;
  String? greeting;
  Streak? streak;

  User({this.name, this.greeting, this.streak});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    greeting = json['greeting'];
    streak =
        json['streak'] != null ? new Streak.fromJson(json['streak']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['greeting'] = this.greeting;
    if (this.streak != null) {
      data['streak'] = this.streak!.toJson();
    }
    return data;
  }
}

class Streak {
  int? days;
  String? icon;

  Streak({this.days, this.icon});

  Streak.fromJson(Map<String, dynamic> json) {
    days = json['days'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['days'] = this.days;
    data['icon'] = this.icon;
    return data;
  }
}

class HeroBanners {
  int? id;
  String? title;
  String? image;
  bool? isActive;

  HeroBanners({this.id, this.title, this.image, this.isActive});

  HeroBanners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['is_active'] = this.isActive;
    return data;
  }
}

class ActiveCourse {
  int? id;
  String? title;
  int? progress;
  int? testsCompleted;
  int? totalTests;

  ActiveCourse(
      {this.id,
      this.title,
      this.progress,
      this.testsCompleted,
      this.totalTests});

  ActiveCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    progress = json['progress'];
    testsCompleted = json['tests_completed'];
    totalTests = json['total_tests'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['progress'] = this.progress;
    data['tests_completed'] = this.testsCompleted;
    data['total_tests'] = this.totalTests;
    return data;
  }
}

class PopularCourses {
  int? id;
  String? name;
  List<Courses>? courses;

  PopularCourses({this.id, this.name, this.courses});

  PopularCourses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.courses != null) {
      data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? id;
  String? title;
  String? image;
  String? action;

  Courses({this.id, this.title, this.image, this.action});

  Courses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['action'] = this.action;
    return data;
  }
}

class LiveSession {
  int? id;
  bool? isLive;
  String? title;
  Instructor? instructor;
  SessionDetails? sessionDetails;
  String? action;

  LiveSession(
      {this.id,
      this.isLive,
      this.title,
      this.instructor,
      this.sessionDetails,
      this.action});

  LiveSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isLive = json['is_live'];
    title = json['title'];
    instructor = json['instructor'] != null
        ? new Instructor.fromJson(json['instructor'])
        : null;
    sessionDetails = json['session_details'] != null
        ? new SessionDetails.fromJson(json['session_details'])
        : null;
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_live'] = this.isLive;
    data['title'] = this.title;
    if (this.instructor != null) {
      data['instructor'] = this.instructor!.toJson();
    }
    if (this.sessionDetails != null) {
      data['session_details'] = this.sessionDetails!.toJson();
    }
    data['action'] = this.action;
    return data;
  }
}

class Instructor {
  String? name;

  Instructor({this.name});

  Instructor.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class SessionDetails {
  int? sessionNumber;
  String? date;
  String? time;

  SessionDetails({this.sessionNumber, this.date, this.time});

  SessionDetails.fromJson(Map<String, dynamic> json) {
    sessionNumber = json['session_number'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_number'] = this.sessionNumber;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}

class Community {
  int? id;
  String? name;
  int? activeMembers;
  String? description;
  RecentActivity? recentActivity;
  String? action;

  Community(
      {this.id,
      this.name,
      this.activeMembers,
      this.description,
      this.recentActivity,
      this.action});

  Community.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    activeMembers = json['active_members'];
    description = json['description'];
    recentActivity = json['recent_activity'] != null
        ? new RecentActivity.fromJson(json['recent_activity'])
        : null;
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['active_members'] = this.activeMembers;
    data['description'] = this.description;
    if (this.recentActivity != null) {
      data['recent_activity'] = this.recentActivity!.toJson();
    }
    data['action'] = this.action;
    return data;
  }
}

class RecentActivity {
  int? recentPosts;
  String? status;
  List<RecentMembers>? recentMembers;

  RecentActivity({this.recentPosts, this.status, this.recentMembers});

  RecentActivity.fromJson(Map<String, dynamic> json) {
    recentPosts = json['recent_posts'];
    status = json['status'];
    if (json['recent_members'] != null) {
      recentMembers = <RecentMembers>[];
      json['recent_members'].forEach((v) {
        recentMembers!.add(new RecentMembers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recent_posts'] = this.recentPosts;
    data['status'] = this.status;
    if (this.recentMembers != null) {
      data['recent_members'] =
          this.recentMembers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentMembers {
  int? id;
  String? avatar;

  RecentMembers({this.id, this.avatar});

  RecentMembers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Testimonials {
  int? id;
  Learner? learner;
  String? review;
  bool? isActive;

  Testimonials({this.id, this.learner, this.review, this.isActive});

  Testimonials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    learner =
        json['learner'] != null ? new Learner.fromJson(json['learner']) : null;
    review = json['review'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.learner != null) {
      data['learner'] = this.learner!.toJson();
    }
    data['review'] = this.review;
    data['is_active'] = this.isActive;
    return data;
  }
}

class Learner {
  String? name;
  String? avatar;

  Learner({this.name, this.avatar});

  Learner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    return data;
  }
}

class Support {
  String? title;
  String? description;
  String? exampleQuestion;
  String? illustration;
  List<Actions>? actions;

  Support(
      {this.title,
      this.description,
      this.exampleQuestion,
      this.illustration,
      this.actions});

  Support.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    exampleQuestion = json['example_question'];
    illustration = json['illustration'];
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(new Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['example_question'] = this.exampleQuestion;
    data['illustration'] = this.illustration;
    if (this.actions != null) {
      data['actions'] = this.actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actions {
  String? type;
  String? label;
  String? icon;

  Actions({this.type, this.label, this.icon});

  Actions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['label'] = this.label;
    data['icon'] = this.icon;
    return data;
  }
}
