package org.hld.invoice.dao;

import org.hld.invoice.entity.Record;

import java.util.Date;
import java.util.List;

/**
 * Created by 李浩然 On 2017/8/10.
 */
public interface RecordDao extends BaseDao<Record, Long> {

    List<Record> findRecords(boolean fuzzy, Date start, Date end, String... params);
}
