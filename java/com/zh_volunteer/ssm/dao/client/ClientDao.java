package com.zh_volunteer.ssm.dao.client;

import com.zh_volunteer.ssm.pojo.Activity;
import com.zh_volunteer.ssm.pojo.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;

import java.util.List;

public interface ClientDao {
    /**
     * 学生登录
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @Select("select id,username,password,gender,phone_num,limit_id,stu_id,state_id,tie from tb_user where (stu_id=#{username} OR phone_num=#{username}) AND password=#{password} and (limit_id=1 or limit_id=2)")
    @Results({
            @Result(column="phone_num", property="phone_num", jdbcType= JdbcType.VARCHAR),
            @Result(column="limit_id", property="limit_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="stu_id", property="stu_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="state_id", property="state_id", jdbcType=JdbcType.CHAR)
    })
    User login(@Param("username") String username, @Param("password") String password) throws Exception;
    /**
     * 通过活动类型查询活动
     * @param activityType
     * @return
     */
    @Select("select id,activity_name,tie,time,activity_type,end_time,activity_state from tb_activity where activity_type=#{activityType} and state=2 limit 0,10")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="end_time", property="end_time", jdbcType= JdbcType.DATE),
            @Result(column="activity_state", property="activity_state", jdbcType= JdbcType.INTEGER)
    })
    List<Activity> findSuchActivityByActivityType(String activityType);
    /**
     * 任意查询
     * @param activity_type
     * @param tie_id
     * @return
     */
    @Select("select id,activity_name,tie,time,activity_type from tb_activity where activity_type=#{activity_type} and tie=#{tie_id} and state=2 limit 0,10")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> randomFind(@Param("activity_type") String activity_type, @Param("tie_id") String tie_id);
    /**
     * 查询全部活动
     * @return
     * @throws Exception
     */
    @Select("select id,activity_name,tie,time,activity_type,end_time,activity_state from tb_activity where state=2 limit 0,5")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="end_time", property="end_time", jdbcType= JdbcType.DATE),
            @Result(column="activity_state", property="activity_state", jdbcType= JdbcType.INTEGER),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> findAllActivity() throws Exception;
    /**
     * 通过活动id查询活动
     * @param activity_id
     * @return
     */
    @Select("select * from tb_activity where id=#{activity_id} and state=2")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="id", property="id", jdbcType= JdbcType.INTEGER),
            @Result(column="activity_introduce", property="activity_introduce", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_details", property="activity_details", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="photo_path", property="photo_path", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_remarks", property="activity_remarks", jdbcType=JdbcType.CHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="end_time", property="end_time", jdbcType=JdbcType.DATE),
            @Result(column="activity_total_number", property="activity_total_number", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_current_number", property="activity_current_number", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_place", property="activity_place", jdbcType=JdbcType.VARCHAR),
            @Result(column="activity_score", property="activity_score", jdbcType=JdbcType.VARCHAR)

    })
    Activity findOneActivityByActivity_id(String activity_id);
    /**
     * limit查询
     * @param firstLimit
     * @param afterLimit
     * @param activityType
     * @param tie
     * @return
     */
    @Select("select id,activity_name,tie,time,activity_type from tb_activity where activity_type=#{activityType} and tie=#{tie} and state=2 limit #{firstLimit},10")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> findAllActivityLimit(@Param("firstLimit") Integer firstLimit, @Param("afterLimit")Integer afterLimit, @Param("activityType")String activityType, @Param("tie")String tie);
    /**
     *limit查询没有系别
     * @param firstLimit
     * @param activityType
     * @return
     */
    @Select("select id,activity_name,tie,time,activity_type from tb_activity where activity_type=#{activityType} and state=2 limit #{firstLimit},10")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> getFixLimitActivitiesNotTie(@Param("firstLimit")Integer firstLimit, @Param("activityType")String activityType);
    @Select("select id,activity_name,tie,time,activity_type,end_time,activity_state from tb_activity where tie=#{tie} and state=2 limit 0,10")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="end_time", property="end_time", jdbcType= JdbcType.DATE),
            @Result(column="activity_state", property="activity_state", jdbcType= JdbcType.INTEGER)
    })
    List<Activity> findSuchActivityByTie(String tie) throws Exception;

    @Select("select id,activity_name,tie,time,activity_type from tb_activity where tie=#{tie} and state=2 limit #{firstLimit},10")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> getFixLimitTieNotActivities(@Param("firstLimit")Integer firstLimit, @Param("tie")String tie);
    /**
     * 根据tie查询count
     * @param tie
     * @return
     */
    @Select("select count(*) from tb_activity where tie=#{tie} and state=2")
    Integer findCountByTie(String tie);
    /**
     * 根据activity_type查询count
     * @param actType
     * @return
     */
    @Select("select count(*) from tb_activity where activity_type=#{actType} and state=2")
    Integer findCountByType(String actType);
    /**
     * 查询count
     * @return
     */
    @Select("select count(*) from tb_activity and state=2 ")
    Integer findCounts();
    @Select("select count(*) from tb_activity where tie=#{tieStr} and activity_type=#{typeStr}  and state=2")
    Integer findCountByTieAndType(@Param("tieStr") String tieStr, @Param("typeStr") String typeStr);
    /**
     * 查询用户
     * @param stuId
     * @return
     * @throws Exception
     */
    @Select("select * from tb_user where stu_id=#{stuId}")
    @Results({
            @Result(column="phone_num", property="phone_num", jdbcType= JdbcType.VARCHAR),
            @Result(column="limit_id", property="limit_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="stu_id", property="stu_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="state_id", property="state_id", jdbcType=JdbcType.CHAR),
            @Result(column="credits", property="credits", jdbcType=JdbcType.INTEGER)

    })
    User findUserById(String stuId) throws Exception;

    @Insert("insert into tb_signup(stu_id,activity_id,signUp_time) values(#{stu_id},#{activity_id},#{time})")
    Boolean signUpActivity(@Param("activity_id") String activity_id,@Param("stu_id") String stu_id,@Param("time") String time);

    @Select("SELECT id FROM tb_activity WHERE activity_current_number < activity_total_number AND id = #{activity_id}")
    String isCanSignUp(String activity_id);

    @Select("select id from tb_signup where stu_id=#{stu_id} and activity_id=#{activity_id}")
    String hasSignUp(@Param("activity_id") String activity_id, @Param("stu_id") String stu_id);

    @Update("update tb_activity set activity_current_number=activity_current_number+1 where id = #{activity_id}")
    void currentNumberPlus(String activity_id);

    @Select("SELECT a.activity_name,a.tie,a.time,a.id,a.end_time FROM tb_signup AS s RIGHT JOIN tb_activity AS a ON s.activity_id=a.id WHERE s.stu_id=#{stu_id} and s.signUp_state=2")
    @Results({
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="tie", property="tie", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType= JdbcType.VARCHAR),
            @Result(column="end_time", property="end_time", jdbcType= JdbcType.VARCHAR),
            @Result(column="id", property="id", jdbcType= JdbcType.VARCHAR)
    })
    List<Activity> selectActivityBySignUp(String stu_id);

    @Update("update tb_user set phone_num=#{phone_num},gender=#{gender} where stu_id=#{stu_id}")
    Boolean updateStuInfo(@Param("stu_id") String stu_id,@Param("phone_num") String phone_num,@Param("gender") String gender);

    @Update("update tb_user set password=#{newPassword} where stu_id=#{stu_id}")
    void updateStuPaw( @Param("stu_id")String stu_id, @Param("newPassword") String newPassword);

    @Select("select id,activity_name,tie,time,activity_type from tb_activity where activity_name like  CONCAT('%',#{key},'%') and state=2 limit 0,10")
    @Results({
            @Result(column="activity_name", property="activity_name"),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> chartBoxSearchByKey(String key);

    @Select("select id,activity_name,tie,time,activity_type from tb_activity where tie=#{tie}  and activity_name like  CONCAT('%',#{key},'%') and state=2 limit 0,10")
    @Results({
            @Result(column="activity_name", property="activity_name"),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> searchByChartBoxAndTie(@Param("key") String key, @Param("tie") String tie);

    @Select("SELECT COUNT(*) FROM tb_activity WHERE activity_name LIKE  CONCAT('%',#{key},'%') and state=2")
    Integer selectByChatBoxCount(String key);

    @Select("SELECT COUNT(*) FROM tb_activity WHERE activity_name LIKE  CONCAT('%',#{key},'%') and tie=#{tie} and state=2")
    Integer selectByChatBoxCountAndTie(@Param("key")String key,@Param("tie")String tie);

    @Select("select id,activity_name,tie,time,activity_type from tb_activity where activity_name like  CONCAT('%',#{key},'%') and state=2 limit #{limit},10")
    @Results({
            @Result(column="activity_name", property="activity_name"),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> queryGroupNotTie(@Param("key") String key, @Param("limit") Integer limit);

    @Select("select id,activity_name,tie,time,activity_type from tb_activity where  tie=#{tie} and activity_name like  CONCAT('%',#{key},'%') and state=2 limit #{limit},10")
    @Results({
            @Result(column="activity_name", property="activity_name"),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> queryGroupHaveTie(@Param("key") String key, @Param("limit") Integer limit, @Param("tie") String tie);

    @Select("SELECT username,stu_id,credits FROM tb_user  ORDER BY credits DESC  LIMIT 0 ,10 ")
    @Results({
            @Result(column="username", property="username", jdbcType= JdbcType.VARCHAR),
            @Result(column="stu_id", property="stu_id", jdbcType= JdbcType.VARCHAR),
            @Result(column="credits", property="credits", jdbcType= JdbcType.INTEGER)
    })
    List<User> selectTopTenStudent() throws Exception;
}
