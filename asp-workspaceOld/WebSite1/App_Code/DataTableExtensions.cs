using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

/// <summary>
/// Summary description for DataTableExtensions
/// </summary>
public static class DataTableExtensions
{

    public static IEnumerable<DataRow> Intersect(this DataTable table, DataTable other)
    {
        return table.AsEnumerable().Intersect(other.AsEnumerable());
    }

    public static IEnumerable<DataRow> Intersect(this DataTable table, DataTable other, IEqualityComparer<DataRow> comparer)
    {
        return table.AsEnumerable().Intersect(other.AsEnumerable(), comparer);
    }
}