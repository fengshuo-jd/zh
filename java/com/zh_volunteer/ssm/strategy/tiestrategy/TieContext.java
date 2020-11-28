package com.zh_volunteer.ssm.strategy.tiestrategy;

public class TieContext {
    private String type;
    private TieStrategy tieStrategy;

    public TieContext(String type, TieStrategy tieStrategy1) {
        this.type = type;
        this.tieStrategy = tieStrategy1;
    }

    public TieStrategy getRoleStrategy() {
        return tieStrategy;
    }
    public boolean options(String type){
        return this.type.equals(type);
    }
}
