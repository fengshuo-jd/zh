package com.zh_volunteer.ssm.pojo;

public class User {
    private Integer id;
    private String username;
    private String password;
    private String gender;
    private String phone_num;
    private Integer limit_id;
    private String stu_id;
    private String state_id;
    private Integer tie;
    private String signUpTime;
    private Integer credits;
    private String signUp_state;
    /**
     * flag 用来判断是否学分已经加一
     */
    private Integer flag;

    public User(Integer id, String username, String password, String gender, String phone_num, Integer limit_id, String stu_id, String state_id, Integer tie, String signUpTime, Integer credits, String signUp_state) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.gender = gender;
        this.phone_num = phone_num;
        this.limit_id = limit_id;
        this.stu_id = stu_id;
        this.state_id = state_id;
        this.tie = tie;
        this.signUpTime = signUpTime;
        this.credits = credits;
        this.signUp_state = signUp_state;
    }

    public String getSignUp_state() {
        return signUp_state;
    }

    public void setSignUp_state(String signUp_state) {
        this.signUp_state = signUp_state;
    }

    public Integer getCredits() {
        return credits;
    }

    public void setCredits(Integer credits) {
        this.credits = credits;
    }

    public String getSignUpTime() {
        return signUpTime;
    }

    public void setSignUpTime(String signUpTime) {
        this.signUpTime = signUpTime;
    }

    public User(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", gender='" + gender + '\'' +
                ", phone_num='" + phone_num + '\'' +
                ", limit_id=" + limit_id +
                ", stu_id='" + stu_id + '\'' +
                ", state_id='" + state_id + '\'' +
                ", tie=" + tie +
                ", signUpTime='" + signUpTime + '\'' +
                ", credits=" + credits +
                '}';
    }

    public User() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone_num() {
        return phone_num;
    }

    public void setPhone_num(String phone_num) {
        this.phone_num = phone_num;
    }

    public Integer getLimit_id() {
        return limit_id;
    }

    public void setLimit_id(Integer limit_id) {
        this.limit_id = limit_id;
    }

    public String getStu_id() {
        return stu_id;
    }

    public void setStu_id(String stu_id) {
        this.stu_id = stu_id;
    }

    public String getState_id() {
        return state_id;
    }

    public void setState_id(String state_id) {
        this.state_id = state_id;
    }

    public Integer getTie() {
        return tie;
    }

    public void setTie(Integer tie) {
        this.tie = tie;
    }
}

