package com.zh_volunteer.ssm.dao.back;

import com.zh_volunteer.ssm.pojo.Activity;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.type.JdbcType;

import java.util.List;

public interface ActivityDao {
    /**
     * 查找所有活动
     * @return
     * @throws Exception
     */
    @Select("select * from tb_activity limit 0,10")
    @Results(id = "select", value = {
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_introduce", property="activity_introduce", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_details", property="activity_details", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="photo_path", property="photo_path", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_remarks", property="activity_remarks", jdbcType=JdbcType.CHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE),
            @Result(column="end_time", property="end_time", jdbcType=JdbcType.DATE),
            @Result(column="activity_score", property="activity_score", jdbcType=JdbcType.INTEGER),
            @Result(column="activity_place", property="activity_place", jdbcType=JdbcType.VARCHAR)

    })
    List<Activity> findAll() throws Exception;
    /**
     * 审批一个活动
     * @param radio
     * @param remarks
     * @param id
     */
    @Update("update tb_activity set state=#{radio},activity_remarks=#{remarks} where id=#{id}")
    void activityExamOne(@Param("radio") String radio, @Param("remarks") String remarks, @Param("id") String id);
    /**
     * 删除一个活动
      * @param id
     * @throws Exception
     */
    @Delete("delete from tb_activity where id = #{id}")
    void deleteActivity(String id) throws Exception;
    /**
     * 通过状态查询
     * @param id
     * @return
     * @throws Exception
     */
    @Select("select * from tb_activity where state=#{id} limit 0,10")
    @Results(id = "stateSelect",value = {
            @Result(column="activity_name", property="activity_name", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_introduce", property="activity_introduce", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_details", property="activity_details", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_type", property="activity_type", jdbcType= JdbcType.VARCHAR),
            @Result(column="photo_path", property="photo_path", jdbcType= JdbcType.VARCHAR),
            @Result(column="activity_remarks", property="activity_remarks", jdbcType=JdbcType.CHAR),
            @Result(column="time", property="time", jdbcType=JdbcType.DATE)
    })
    List<Activity> suchFind(String id) throws Exception;

    @Select("select count(*) from tb_activity where state=#{id} ")
    Integer suchFindCount(String id) throws Exception;

    @Select("SELECT * FROM tb_activity WHERE activity_name LIKE CONCAT('%',#{activity_name},'%') limit 0,10")
    @ResultMap(value="select")
    List<Activity> charBoxByActivityName(String activity_name);

    @Select("select count(*) from tb_activity")
    Integer findAllCount() throws Exception;

    @Select("select * from tb_activity limit #{n},10")
    @ResultMap(value="select")
    List<Activity> pageFindByPageNum(int n);

    @Select("SELECT * FROM tb_activity WHERE activity_name LIKE CONCAT('%',#{activity_name},'%') limit #{page},10")
    @ResultMap(value="select")
    List<Activity> pageFindByPageNumAndSearchContent(@Param("activity_name") String finalStr, @Param("page")int n) throws Exception;

    @Select("SELECT count(*) FROM tb_activity WHERE activity_name LIKE CONCAT('%',#{activity_name},'%')")
    Integer charBoxByActivityNameCount(String activity_name);

    @Select(" SELECT * FROM tb_activity WHERE  state = #{stateId} limit #{page},10")
    @ResultMap(value="select")
    List<Activity> pageFindByPageNumAndStateId(@Param("stateId") String stateId,@Param("page") Integer page);

    @Select("SELECT * FROM tb_activity WHERE activity_name LIKE CONCAT('%',#{activity_name},'%') AND state = #{stateId} LIMIT #{page},10")
    @ResultMap(value="select")
    List<Activity> pageFindByPageNumAndSearchContentAndStateId(@Param("activity_name")String str, @Param("stateId")String stateId, @Param("page")int n);

    @Select("select * from tb_activity where activity_name LIKE CONCAT('%',#{activity_name},'%') and state=#{stateId} limit 0,10")
    @ResultMap(value="stateSelect")
    List<Activity> pageFindByPageNumAndSearchContentAndStateIdA(@Param("activity_name") String str, @Param("stateId") String s);

    @Select("select count(*) from tb_activity where activity_name LIKE CONCAT('%',#{activity_name},'%') and state=#{stateId}")
    Integer pageFindByPageNumAndSearchContentAndStateIdACount(@Param("activity_name") String str, @Param("stateId") String s);

}

