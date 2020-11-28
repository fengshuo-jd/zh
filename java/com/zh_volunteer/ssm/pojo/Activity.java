package com.zh_volunteer.ssm.pojo;

public class Activity {

    private Integer id;
    private String creator;
//    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    private String time;
    private String end_time;
    private String state;
    private String activity_name;
    private String activity_introduce;
    private String activity_details;
    private String activity_remarks;
    private String activity_type;
    private String photo_path;
    private String tie;
    private String activity_total_number;
    private String activity_current_number;
    private String activity_state;
    private Integer activity_score;
    private String activity_place;

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public String getActivity_state() {
        return activity_state;
    }

    public void setActivity_state(String activity_state) {
        this.activity_state = activity_state;
    }

    public Integer getActivity_score() {
        return activity_score;
    }

    public void setActivity_score(Integer activity_score) {
        this.activity_score = activity_score;
    }

    public String getActivity_place() {
        return activity_place;
    }

    public void setActivity_place(String activity_place) {
        this.activity_place = activity_place;
    }

    public String getActivity_total_number() {
        return activity_total_number;
    }

    public void setActivity_total_number(String activity_total_number) {
        this.activity_total_number = activity_total_number;
    }

    public String getActivity_current_number() {
        return activity_current_number;
    }

    public void setActivity_current_number(String activity_current_number) {
        this.activity_current_number = activity_current_number;
    }

    public Activity() {
    }

    @Override
    public String toString() {
        return "Activity{" +
                "id=" + id +
                ", creator='" + creator + '\'' +
                ", time='" + time + '\'' +
                ", state='" + state + '\'' +
                ", activity_name='" + activity_name + '\'' +
                ", activity_introduce='" + activity_introduce + '\'' +
                ", activity_details='" + activity_details + '\'' +
                ", activity_remarks='" + activity_remarks + '\'' +
                ", activity_type='" + activity_type + '\'' +
                ", photo_path='" + photo_path + '\'' +
                ", tie='" + tie + '\'' +
                '}';
    }

//    public Activity(Integer id, String creator, String time, String state, String activity_name, String activity_introduce, String activity_details, String activity_remarks, String activity_type, String photo_path, String tie) {
//        this.id = id;
//        this.creator = creator;
//        this.time = time;
//        this.state = state;
//        this.activity_name = activity_name;
//        this.activity_introduce = activity_introduce;
//        this.activity_details = activity_details;
//        this.activity_remarks = activity_remarks;
//        this.activity_type = activity_type;
//        this.photo_path = photo_path;
//        this.tie = tie;
//    }


    public Activity(Integer id, String creator, String time, String end_time, String state, String activity_name, String activity_introduce, String activity_details, String activity_remarks, String activity_type, String photo_path, String tie, String activity_total_number, String activity_current_number, String activity_state, Integer activity_score, String activity_place) {
        this.id = id;
        this.creator = creator;
        this.time = time;
        this.end_time = end_time;
        this.state = state;
        this.activity_name = activity_name;
        this.activity_introduce = activity_introduce;
        this.activity_details = activity_details;
        this.activity_remarks = activity_remarks;
        this.activity_type = activity_type;
        this.photo_path = photo_path;
        this.tie = tie;
        this.activity_total_number = activity_total_number;
        this.activity_current_number = activity_current_number;
        this.activity_state = activity_state;
        this.activity_score = activity_score;
        this.activity_place = activity_place;
    }

    public Activity(Integer id, String creator, String time, String state, String activity_name, String activity_introduce, String activity_details, String activity_remarks, String activity_type, String photo_path, String tie, String activity_total_number, String activity_current_number) {
        this.id = id;
        this.creator = creator;
        this.time = time;
        this.state = state;
        this.activity_name = activity_name;
        this.activity_introduce = activity_introduce;
        this.activity_details = activity_details;
        this.activity_remarks = activity_remarks;
        this.activity_type = activity_type;
        this.photo_path = photo_path;
        this.tie = tie;
        this.activity_total_number = activity_total_number;
        this.activity_current_number = activity_current_number;
    }

    public String getActivity_type() {
        return activity_type;
    }

    public void setActivity_type(String activity_type) {
        this.activity_type = activity_type;
    }

    public String getPhoto_path() {
        return photo_path;
    }

    public void setPhoto_path(String photo_path) {
        this.photo_path = photo_path;
    }

    public String getActivity_details() {
        return activity_details;
    }

    public void setActivity_details(String activity_details) {
        this.activity_details = activity_details;
    }

    public String getTie() {
        return tie;
    }

    public void setTie(String tie) {
        this.tie = tie;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getActivity_name() {
        return activity_name;
    }

    public void setActivity_name(String activity_name) {
        this.activity_name = activity_name;
    }

    public String getActivity_introduce() {
        return activity_introduce;
    }

    public void setActivity_introduce(String activity_introduce) {
        this.activity_introduce = activity_introduce;
    }

    public String getActivity_remarks() {
        return activity_remarks;
    }

    public void setActivity_remarks(String activity_remarks) {
        this.activity_remarks = activity_remarks;
    }
}

