/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 11/12/2010
 * Time: 18:23
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class Result
  {
    public var success:Boolean = false;
    public var instance:Object;

    public function Result(success:Boolean = true, instance:Object = null)
    {
      this.success = success;
      this.instance = instance;
    }
  }
}
